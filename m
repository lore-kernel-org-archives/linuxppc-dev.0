Date: 2 May 2002 13:09:32 -0000
Message-ID: <20020502130932.3019.qmail@webmail11.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: USB problem ..
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am facing specific problems in getting USB working on
mpc823.

sometimes it gets hanged as soon I write to USCOM (usb command)
register , also I am not able to set
"endpoint->tstate" equal to zero during initialisation.

I can see that it indefinitely keeps awaiting for idle
bit set in USBS(usb status register) register.

as per the MPC823 manual I should first operate on cpcr
(cpm command register) with usb commands before issuing
USCOM but their example code doesn't do that.

I am using only endpoint zero.

should I use my buffers in dpram or host memory?
any issues specific to this...

any pointer on this / known issues or working driver code..

with Regards,
Navin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
