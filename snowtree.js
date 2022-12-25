const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');

var leaves = [ ".", "*", "+", "o", "O"];
var color = ["red", "purple", "blue", "white"];
function random(max){ return Math.floor(Math.random()*max) }
ctx.fillStyle = 'yellow';
ctx.fillText("☆", 150, 510);
ctx.fillStyle = 'green';
for(i=20; i>0; i--){
    for(j=20; j>i; j--)
	ctx.fillText(" ", i*10+140, j*10+500);
    for(j=20; j>(i*2-1); j--){
	if(random(50) == 25 || random(100) == 1)
	    ctx.fillStyle = color[random(4)];
	ctx.fillText(leaves[random(4)], i*10+140, j*10+500);
	ctx.fillStyle = 'green';
    }
    for(j=20; j>i; j--)
	ctx.fillText(" ", (20-i*10)+140, j*10+500);
    for(j=20; j>(i*2-1); j--){
	if(random(50) == 25 || random(100) == 1)
	    ctx.fillStyle = color[random(4)];
	ctx.fillText(leaves[random(4)], (20-i*10)+140, j*10+500);
    }
}
ctx.fillStyle = 'rgb(155, 90, 90)';
for(i=800; i>710; i--)
    for(j=0; j<20; j++)
	ctx.fillText("#", 140+j, i);

