Date: 7 Aug 2002 13:28:57 -0000
Message-ID: <20020807132857.17253.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "navinb" <ppc4@rediffmail.com>
Reply-To: "navinb" <ppc4@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: microcode patch requires dreq1 for sof generation ..?
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

i amn't able to answer a question pointed by somebody regarding
usb host 8xx (rpxite ) microcode patch.

it requires a one khz signal to pc15 ( dreq1)for sof generation.
but dreq1 is employed by for IDMA request as per mpc8xx manual.
my question is why microcode patch requires dreq1 for sof
generation ?

is there something special about this..?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
