Message-ID: <38BE8538.23D168B5@jlc.net>
Date: Thu, 02 Mar 2000 10:14:00 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: duyrat1 <duyrat1@col.bsf.alcatel.fr>
CC: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
        Laurent Barbero <barbero@cabs40>
Subject: Re: reset of the CPM
References: <38BE22E0.69E80DE5@col.bsf.alcatel.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


duyrat1 wrote:
>
> hy,
>
> In linux v2.2.12 release (and till in 2.3.47):

> What is the role of this patch?

This one in particular is on the MBX860 board.  It relocates the
I2C parameter ram when SCC1 is used for Ethernet.

I have since become smarter, and I am now making Linux install
it's own microcode patches.  This is necessary because drivers have
to be modified to know such patches exist, as the programming
interface physically and logically changes.  It is now appropriate
to reset the CPM and remove all existing configurations.

> and then on a reset or when a NMI exception is generated, does that
> mean  that no reset of the CPM must ever be done.

I don't remember the effect of external resets on the CPM.  I am
travelling right now and don't have the book handy.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
