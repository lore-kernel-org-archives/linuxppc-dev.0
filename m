Message-ID: <005901c288bc$3ed80990$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: TLB SETTING in 440GP
Date: Sun, 10 Nov 2002 18:52:40 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

Can anybody tell me how the TLB setting is done in PPC 440GP linux. I did a
comparison of TLB mapping between  eval kit and my proprietary board. There
is a huge difference between the both.

Below is the comparison between Eval and Proprietary boards with some sample
TLB numbers

EVAL KIT TLB MAPPING

TLB         EPN            V     S    TS    T        E+RPN
U0123        WIMG        E        UXWR    SXWR
00        C12AD000      1     1     1     00    0012AD000             0000
0001         0            101          111
01        C10111000      1     1     1     00   0010111000             0000
0001         0            101          111
02        C78BC000      1     1     1     00    0078BC000             0000
0001         0            101          111
03        C12AF000      1     1     1     00    0012AF000             0000
0001         0            101          111
04        C12B0000      1     1     1     00    0012B0000             0000
0001         0            101          111
05        C103C000      1     1     1     00    00103C000             0000
0001         0            101          111
07        FDEF9000      1     1     1     00    140000000             0000
0001         0            101          111
12        0FE70000      1     1     1     00     007999000             0000
0001         0            101          111
16        10098000      1     1     1     00     00124F000             0000
0001         0            101          111
37        7FFFF000      1     1     1     00     00117E000             0000
0001         0            101          111

PROPRIETARY BOARD TLB MAPPING

00        C1285000      1     1     1     00   001285000             0000
0001         0            101          111
01        C7A84000   1     1     1     00    007A840000             0000
0001         0            101          111
02        C1286000     1     1     1     00    001286000             0000
0001         0            101          111
03        C7A83000      1     1     1     00    007A83000             0000
0001         0            101          111
04        C7A82000      1     1     1     00    007A82000             0000
0001         0            101          111
05        C1287000     1     1     1     00    001287000             0000
0001         0            101          111
07        FDEF9000      1     1     1     00    140000000             0000
0001         0            101          111
12        C12BF000      1     1     1     00     0012BF000             0000
0001         0            101          111
16        C1289000     1     1     1     00     001289000            0000
0001         0            101          111
37        C12F9000      1     1     1     00    0012F9000             0000
0001         0            101          111

In the above tlb setting , eval kit has tlb EPN starting with  0xC or 0xF or
0x1 or 0x7 where as in the proprietary board the EPN always start with 0xC.
As the TLB setting is not done by me , why is there a vast difference?. Will
this cause any problems during the  kernel booting?.

Can anyone help me in understanding this tlb setting.

Thanking you in advance
Regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
