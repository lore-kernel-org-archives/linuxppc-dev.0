Message-Id: <5.1.0.14.0.20011107105313.00a4ba40@spudcentral.com>
Date: Wed, 07 Nov 2001 10:53:44 -0700
To: kingseft@samsung.co.kr, linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: Question about Interrupt on MPC8xx
In-Reply-To: <H00002af054f0701@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 03:03 PM 11/7/2001 +0900, kingseft@samsung.co.kr wrote:

> Hi,
>
> I have a question about interrupt on MPC8xx.
> I conneted Dip switch to IRQ1 on MPC860. When I push down the button, Interrupt occurred and interrupt service routine worked.
> But, I didn't understand that I set falling edge interrupt detection via SIEL on MPC8xx.
> when I push up Dip switch, my interrupt routein also worked.
> Why this happend in spite of setting falling edge??

debounce the switch.


> Could anyone help me with this problem? Any comments will help me.
> Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
