Message-Id: <5.1.0.14.2.20030723141505.03528ef8@falcon.si.com>
Date: Wed, 23 Jul 2003 14:21:05 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: EP8260 
In-Reply-To: <1058882554.3f1d43faafee2@pop-mail.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


a) What Wolfgang said :-).

b) What does your EP8260 config file have in it for CONFIG_BAUDRATE?  Did
you override it in the environmental variables and inadvertently switch to
a different baud rate?  Did you try different baud rates with minicom to
see if you could find the one the EP8260 is using?

ANSI vs. VT100 isn't going to do much for you (that is escape
sequences).  It looks like a baud rate mismatch.  It might be 7 bit vs. 8
bit or parity, but not likely.


gvb


At 07:32 AM 7/22/2003 +0530, deepesh@india.tejasnetworks.com wrote:

>Hi,
>
>   I loaded my EP8260 board with UBOOT. This was working fine. Then I loaded a
>binary into RAM using tftp. Then tried copying the stuff to flash. When I
>could
>not copy things into flash directly, I erased a few sectors randomly and then
>copied the binary to flash. Then when I reset the board, it did not come up.
>
>I put back the u-boot into the flash using BDI2000. But now I am getting weird
>characters on the screen. I have looked at the minicom settings-- It is 115200
>and 8N1. These were the settings with which I was working before also.
>What I am
>not able to understand is the reason for the weird characters.
>
>I am attaching the weird character file. The last line seems to be the U-BOOT
>prompt. I tried changing the TERMINAL SETTINGS to ANSI from VT100, but it did
>not help.
>------------------------------------------------------------------------
>?וךבף`*m,ןןפ`0nsnp`hSץל rr`r0ps`m@qrzs2zrvi
>
>??fxrv0`?וףופ`?פבפץףz@?רפועמבל`?ןזפl ?רפועמבל`Èבעה
>
>??fxrvp fלןדכ`fןמזיחץעבפיןמ
>`m`,ץףmפןmfןעו`?ץלפ`snuרl`-f?`?יצ rl`v0ר`,ץף`?עוס``sp-xu`l fןעו ?עוס qppm3pp
>`m`הזגעח`q,`דןעודמז`0רqוl`גץףהז`rl`דנםהז`ql`נללהז`ql`נללםז`r
>`m`צדןYןץפ``qyxppp0ppl`ףדדYדלכ```tyupppppl`געחYדלכ```1rswup0p
>`m`דנץYדלכ` rsqpppppp,`דנםYדלכ`@`yyp0ppppL`גץףYדלכ```vvp0pppp
>
>f?*z`` ??fxrvp`h?וצ`q4l`?בףכ`?n0h?i`r<ru?)`בפ`2sq`?Èת
>,ןבעהz ?םגוההוה`?לבמופ`??x2vpl`?וציףיןמ`p.p
>?2fz`` עובהש
>????z `vt`?,
>????^:`qv ?,
>jjj`-בעמימח`m`גבה`f?fl`ץףימח`הוזבץלפ`ומציעןמםומפ
>
>?מz` ``ףועיבל
>?ץפz ``ףועיבל
>?עעz ``ףועיבל
>?Åפz```?ffs`??^?????
>,??,*?zעוÁהש
>}~`
>--------------------------------------------------------------------------
>
>Thank you,
>Deepesh
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
