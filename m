Message-Id: <200211260711.BAA18681@lists.linuxppc.org>
From: "=?GB2312?Q?=D3=DA=E6=BA?=" <yuj@mail.ndsc.com.cn>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RE: zynx zx212 dual-port ethernet card
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 26 Nov 2002 15:14:45 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi!
  I'm confused about your words.I noticed that
"#define request_8xxirq request_irq" in /include/asm-ppc/mpc8260.h ,so there should be no difference between request_irq()and request_8xxirq().Right?
  I have no other PCI card at hand,so I didn't boot with other card.

>I am running a 4 port ZX214  on our mpc8265 board. The only change I had  to
>make to the Tulip driver was to change request_irq() to request_8xxirq(). I
>am using a modified 2.18-pre3 kernel.
>
>Can you boot with any other PCI card?
>
>> -----Original Message-----
>> From: yuj@mail.ndsc.com.cn [mailto:yuj@mail.ndsc.com.cn]
>> Sent: Monday, November 25, 2002 7:43 PM
>> To: linuxppc-embedded@lists.linuxppc.org
>> Subject: zynx zx212 dual-port ethernet card
>>
>>   I'm porting hardhat linux v2.1 on my motorola lopec mpc7410
>> board with a zynx zx212 dual-port ethernet card on it.The
>> problem is that the kernel can't start up with the ethernet
>> card on,while without it everything is perfect.Since zx212 is
>> compatible with 21143,I build the kernel with the "tulip"
>> option on.It should be no problem,but it happened.Can anybody
>> tell me the reason?

　　　　　　　　yuj@mail.ndsc.com.cn
　　　　　　　　　　2002-11-26

>From bouncefilter@lists.linuxppc.org  Tue Nov 26 02:14:56 2002
Received: from eins.siemens.at (eins.siemens.at [193.81.246.11])
	by lists.linuxppc.org (8.9.3/8.9.3) with ESMTP id CAA18954
	for <linuxppc-embedded@lists.linuxppc.org>; Tue, 26 Nov 2002 02:14:56 -0600
Received: from scesie13.sie.siemens.at (forix [10.1.140.2])
	by eins.siemens.at  with ESMTP id gAQ8EUU24599
	for <linuxppc-embedded@lists.linuxppc.org>; Tue, 26 Nov 2002 09:14:30 +0100
Received: from vies194a.sie.siemens.at (atws15tc.sie.siemens.at [158.226.135.41])
	by scesie13.sie.siemens.at (8.12.1/8.12.1) with ESMTP id gAQ8EQk1007317
	for <linuxppc-embedded@lists.linuxppc.org>; Tue, 26 Nov 2002 09:14:26 +0100 (MET)
Received: by vies194a.sie.siemens.at with Internet Mail Service (5.5.2653.19)
	id <X13A1D5K>; Tue, 26 Nov 2002 09:15:22 +0100
Message-ID: <4D50D5110555D5119F270800062B41650E921F@viee10pa.erd.siemens.at>
From: Grubmair Peter <peter.grubmair@siemens.com>
To: "'linuxppc-embedded post'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with ping at sash + console
Date: Tue, 26 Nov 2002 09:15:14 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)

Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C29523.F24E31C0"

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C29523.F24E31C0
Content-Type: text/plain;
	charset="iso-8859-1"

At a custom mpc850 board,
only ping -c 1 works,
normal ping does not work.
Ping ist started from a progam with "system()" call.
This program was started at sash on serial console.
Any suggestions ?
  Best regards

          Peter Grubmair

------_=_NextPart_001_01C29523.F24E31C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDMuMi8vRU4iPg0KPEhUTUw+
DQo8SEVBRD4NCjxNRVRBIEhUVFAtRVFVSVY9IkNvbnRlbnQtVHlwZSIgQ09OVEVOVD0idGV4dC9o
dG1sOyBjaGFyc2V0PWlzby04ODU5LTEiPg0KPE1FVEEgTkFNRT0iR2VuZXJhdG9yIiBDT05URU5U
PSJNUyBFeGNoYW5nZSBTZXJ2ZXIgdmVyc2lvbiA1LjUuMjY1My4xMiI+DQo8VElUTEU+UHJvYmxl
bSB3aXRoIHBpbmcgYXQgc2FzaCArIGNvbnNvbGU8L1RJVExFPg0KPC9IRUFEPg0KPEJPRFk+DQoN
CjxQPjxGT05UIFNJWkU9Mj5BdCBhIGN1c3RvbSBtcGM4NTAgYm9hcmQsPC9GT05UPg0KPEJSPjxG
T05UIFNJWkU9Mj5vbmx5IHBpbmcgLWMgMSB3b3Jrcyw8L0ZPTlQ+DQo8QlI+PEZPTlQgU0laRT0y
Pm5vcm1hbCBwaW5nIGRvZXMgbm90IHdvcmsuPC9GT05UPg0KPEJSPjxGT05UIFNJWkU9Mj5QaW5n
IGlzdCBzdGFydGVkIGZyb20gYSBwcm9nYW0gd2l0aCAmcXVvdDtzeXN0ZW0oKSZxdW90OyBjYWxs
LjwvRk9OVD4NCjxCUj48Rk9OVCBTSVpFPTI+VGhpcyBwcm9ncmFtIHdhcyBzdGFydGVkIGF0IHNh
c2ggb24gc2VyaWFsIGNvbnNvbGUuPC9GT05UPg0KPEJSPjxGT05UIFNJWkU9Mj5Bbnkgc3VnZ2Vz
dGlvbnMgPzwvRk9OVD4NCjxCUj48Rk9OVCBTSVpFPTI+Jm5ic3A7IEJlc3QgcmVnYXJkczwvRk9O
VD4NCjwvUD4NCg0KPFA+PEZPTlQgU0laRT0yPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBQZXRlciBHcnVibWFpcjwvRk9OVD4NCjwvUD4NCg0K
PC9CT0RZPg0KPC9IVE1MPg==

------_=_NextPart_001_01C29523.F24E31C0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
