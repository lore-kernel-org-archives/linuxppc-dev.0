Return-Path: <Modournation@live.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-oln040092010084.outbound.protection.outlook.com [40.92.10.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhHZB3NYwzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 07:41:54 +1100 (AEDT)
From: Kevin Yeske <Modournation@live.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: 
Date: Tue, 21 Nov 2017 20:41:47 +0000
Message-ID: <CO2PR04MB22627F6185164FB2FB160969BE230@CO2PR04MB2262.namprd04.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="_000_CO2PR04MB22627F6185164FB2FB160969BE230CO2PR04MB2262namp_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_CO2PR04MB22627F6185164FB2FB160969BE230CO2PR04MB2262namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello ,

I have been working on trying to get a newer kernel and Ubuntu version runn=
ing on the PS3 within otherOS on a PS3 slim. I managed to find a git reposi=
tory made by Geoff that is still being updated as of a few days ago. That c=
an be found here - https://kernel.googlesource.com/pub/...eoff/ps3-linux<ht=
tps://kernel.googlesource.com/pub/scm/linux/kernel/git/geoff/ps3-linux>. I =
was able to compile it, but when I try to boot from within petitboot using =
this command:

pub/scm/linux/kernel/git/geoff/ps3-linux - Git at Google<https://kernel.goo=
glesource.com/pub/scm/linux/kernel/git/geoff/ps3-linux>
kernel.googlesource.com
Mirrored from git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux=
.git



Code:

kexec -l vmlinux --initrd=3Dinitrd.gz

I am greeted with -
Code:

Warning: append=3D option is not passed. Using the first kernel root partit=
ion
Modified cmdline:
Unable to find /proc/device-tree//chosen/linux,stdout-path, printing from
purgatory is diabled


I am using the following commands
I am a noob when it comes to kernel development and have no idea what I nee=
d to do get fix this. If anyone can help me that would be greatly appreciat=
ed!

I have tried so many things, and am lost as to what I need to do. Some addi=
tional things I have tried:
Code:

http://www.psdevwiki.com/ps3/Booting_Linux_2.6_kernel_on_running_PS3_Linux_=
with_kexec
https://www.kernel.org/pub/linux/kernel/people/geoff/petitboot/lpc-2012/pet=
itboot-lpc-2012.pdf
https://www.vivaolinux.com.br/topico/Comandos/Kernel-for-Newbies-Compilacao=
-facil-do-Kernel
http://psx-scene.com/forums/f119/help-wanted-how-install-xubuntu-ydl-proper=
-hdd-partition-ps3-namely-ps3dd-please-help-me-try-xubuntu-ps3-108488/#post=
1020141
http://www.psdevwiki.com/ps3/OtherOS%2B%2B
https://kernel.googlesource.com/pub/scm/linux/kernel/git/geoff/ps3-linux/+/=
base/Documentation/process/changes.rst
http://psx-scene.com/forums/f119/detailed-guide-install-ubuntu-9-04-jaunty-=
jackalope-internet-accoring-ps3devwiki-glevand-skynet-108907/
https://www.youtube.com/watch?v=3DUpu6X3m8rV0
https://www.youtube.com/watch?v=3D4jGG51riijo
https://www.youtube.com/watch?v=3D0hyZJgNt4to

This is just a small amount of what I have used to get to where I am now..


any help would be much appreciated.

Thanks!

--_000_CO2PR04MB22627F6185164FB2FB160969BE230CO2PR04MB2262namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><span style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera San=
s&quot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; back=
ground-color: rgb(235, 236, 228);">Hello ,</span><br style=3D"font-family: =
Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quot;, &quot;DejaVu Sans&quot=
;, Tahoma, sans-serif; font-size: 13px; background-color: rgb(235, 236, 228=
);">
<br style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quo=
t;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgroun=
d-color: rgb(235, 236, 228);">
<span style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&q=
uot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgro=
und-color: rgb(235, 236, 228);">I have been working on trying to get a newe=
r kernel and Ubuntu version running on the PS3 within
 otherOS on a PS3 slim. I managed to find a git repository made by Geoff th=
at is still being updated as of a few days ago. That can be found here -&nb=
sp;</span><a href=3D"https://kernel.googlesource.com/pub/scm/linux/kernel/g=
it/geoff/ps3-linux" target=3D"_blank" style=3D"color: rgb(221, 72, 20); tex=
t-decoration-line: none; font-family: Ubuntubeta, Ubuntu, &quot;Bitstream V=
era Sans&quot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13p=
x; background-color: rgb(235, 236, 228);" id=3D"LPlnk614450" previewremoved=
=3D"true" tabindex=3D"-1" disabled=3D"true">https://kernel.googlesource.com=
/pub/...eoff/ps3-linux</a><span style=3D"font-family: Ubuntubeta, Ubuntu, &=
quot;Bitstream Vera Sans&quot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif=
; font-size: 13px; background-color: rgb(235, 236, 228);">.
 I was able to compile it, but when I try to boot from within petitboot usi=
ng this command:</span></p>
<div id=3D"LPBorder_GT_15112968258170.05116057976420407" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15112968258100.9953021334574776" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15112968258130.7461047946776029" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15112968258130.1380685716059069"></div>
<div id=3D"LPTitle_15112968258130.1738494903681993" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: wf_seg=
oe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &quot;=
Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-heigh=
t: 21px;">
<a id=3D"LPUrlAnchor_15112968258140.8594489908819447" href=3D"https://kerne=
l.googlesource.com/pub/scm/linux/kernel/git/geoff/ps3-linux" target=3D"_bla=
nk" style=3D"text-decoration: none;" tabindex=3D"-1" disabled=3D"true">pub/=
scm/linux/kernel/git/geoff/ps3-linux - Git at
 Google</a></div>
<div id=3D"LPMetadata_15112968258150.8062168539902355" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 14px;">
kernel.googlesource.com</div>
<div id=3D"LPDescription_15112968258160.8713372901847671" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: wf_segoe-=
ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-=
serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: hid=
den;">
Mirrored from git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux=
.git</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quo=
t;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgroun=
d-color: rgb(235, 236, 228);">
<div class=3D"bbcode_container" style=3D"margin: 5px 20px 20px; padding: 0p=
x; font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quot;, &quot;=
DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; background-color: r=
gb(235, 236, 228);">
<div class=3D"bbcode_description" style=3D"margin: 0px; padding: 0px;">Code=
:</div>
<pre class=3D"bbcode_code" style=3D"margin-top: 0px; margin-bottom: 0px; pa=
dding: 6px; font-family: &quot;Ubuntu Mono&quot;, monospace; line-height: 1=
4px; word-wrap: normal; border: 1px inset; overflow: auto; direction: ltr; =
background: none repeat-x rgb(239, 239, 239); font-size: 14px; height: 36px=
;">kexec -l vmlinux --initrd=3Dinitrd.gz</pre>
</div>
<span style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&q=
uot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgro=
und-color: rgb(235, 236, 228);">I am greeted with -&nbsp;</span><br style=
=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quot;, &quot=
;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; background-color: =
rgb(235, 236, 228);">
<div class=3D"bbcode_container" style=3D"margin: 5px 20px 20px; padding: 0p=
x; font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quot;, &quot;=
DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; background-color: r=
gb(235, 236, 228);">
<div class=3D"bbcode_description" style=3D"margin: 0px; padding: 0px;">Code=
:</div>
<pre class=3D"bbcode_code" style=3D"margin-top: 0px; margin-bottom: 0px; pa=
dding: 6px; font-family: &quot;Ubuntu Mono&quot;, monospace; line-height: 1=
4px; word-wrap: normal; border: 1px inset; overflow: auto; direction: ltr; =
background: none repeat-x rgb(239, 239, 239); font-size: 14px; height: 84px=
;"><font color=3D"#333333"><span style=3D"font-family: arial;">Warning: app=
end=3D option is not passed. Using the first kernel root partition </span><=
/font>=0A=
<font color=3D"#333333"><span style=3D"font-family: arial;">Modified cmdlin=
e: </span></font>=0A=
<font color=3D"#333333"><span style=3D"font-family: arial;">Unable to find =
/proc/device-tree//chosen/linux,stdout-path, printing from </span></font>=
=0A=
<font color=3D"#333333"><span style=3D"font-family: arial;">purgatory is di=
abled =0A=
</span></font></pre>
</div>
<font color=3D"#333333" style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bit=
stream Vera Sans&quot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-s=
ize: 13px; background-color: rgb(235, 236, 228);"><span style=3D"font-famil=
y: arial;"><br>
I am using the following commands&nbsp;<br>
I am a noob when it comes to kernel development and have no idea what I nee=
d to do get fix this. If anyone can help me that would be greatly appreciat=
ed!&nbsp;<br>
<br>
I have tried so many things, and am lost as to what I need to do. Some addi=
tional things I have tried:<br>
</span></font>
<div class=3D"bbcode_container" style=3D"margin: 5px 20px 20px; padding: 0p=
x; font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quot;, &quot;=
DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; background-color: r=
gb(235, 236, 228);">
<div class=3D"bbcode_description" style=3D"margin: 0px; padding: 0px;">Code=
:</div>
<pre class=3D"bbcode_code" style=3D"margin-top: 0px; margin-bottom: 0px; pa=
dding: 6px; font-family: &quot;Ubuntu Mono&quot;, monospace; line-height: 1=
4px; word-wrap: normal; border: 1px inset; overflow: auto; direction: ltr; =
background: none repeat-x rgb(239, 239, 239); font-size: 14px; height: 144p=
x;">http://www.psdevwiki.com/ps3/Booting_Linux_2.6_kernel_on_running_PS3_Li=
nux_with_kexec=0A=
https://www.kernel.org/pub/linux/kernel/people/geoff/petitboot/lpc-2012/pet=
itboot-lpc-2012.pdf=0A=
https://www.vivaolinux.com.br/topico/Comandos/Kernel-for-Newbies-Compilacao=
-facil-do-Kernel=0A=
http://psx-scene.com/forums/f119/help-wanted-how-install-xubuntu-ydl-proper=
-hdd-partition-ps3-namely-ps3dd-please-help-me-try-xubuntu-ps3-108488/#post=
1020141=0A=
http://www.psdevwiki.com/ps3/OtherOS%2B%2B=0A=
https://kernel.googlesource.com/pub/scm/linux/kernel/git/geoff/ps3-linux/&#=
43;/base/Documentation/process/changes.rst=0A=
http://psx-scene.com/forums/f119/detailed-guide-install-ubuntu-9-04-jaunty-=
jackalope-internet-accoring-ps3devwiki-glevand-skynet-108907/=0A=
https://www.youtube.com/watch?v=3DUpu6X3m8rV0=0A=
https://www.youtube.com/watch?v=3D4jGG51riijo=0A=
https://www.youtube.com/watch?v=3D0hyZJgNt4to</pre>
</div>
<span style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&q=
uot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgro=
und-color: rgb(235, 236, 228);">This is just a small amount of what I have =
used to get to where I am now..</span><br style=3D"font-family: Ubuntubeta,=
 Ubuntu, &quot;Bitstream Vera Sans&quot;, &quot;DejaVu Sans&quot;, Tahoma, =
sans-serif; font-size: 13px; background-color: rgb(235, 236, 228);">
<br style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quo=
t;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgroun=
d-color: rgb(235, 236, 228);">
<br style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quo=
t;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgroun=
d-color: rgb(235, 236, 228);">
<span style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&q=
uot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgro=
und-color: rgb(235, 236, 228);">any help would be much appreciated.</span><=
br style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quot=
;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; background=
-color: rgb(235, 236, 228);">
<br style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&quo=
t;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgroun=
d-color: rgb(235, 236, 228);">
<span style=3D"font-family: Ubuntubeta, Ubuntu, &quot;Bitstream Vera Sans&q=
uot;, &quot;DejaVu Sans&quot;, Tahoma, sans-serif; font-size: 13px; backgro=
und-color: rgb(235, 236, 228);">Thanks!</span><br>
<p></p>
</div>
</body>
</html>

--_000_CO2PR04MB22627F6185164FB2FB160969BE230CO2PR04MB2262namp_--
