Message-ID: <3E6CB1CB.8020502@embeddededge.com>
Date: Mon, 10 Mar 2003 10:39:55 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Donald MacArthur <dmacarth@ufl.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Changing Console Baud Rate
References: <NDBBIHDFKLJKGJJGMFJOOECACHAA.dmacarth@ufl.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Donald MacArthur wrote:

> I am currently working with an embedded planet MPC850 credit card board.  I
> am also using the GPL timesys linux kernel.  I recently tried to change the
> console baud rate in the kernel boot parameter from 9600 to 19200 yet when
> the kernel booted up there was no change.  Any ideas on further
> modifications required to change the console baud rate?

The console baud rate is taken from the board information structure, which
is initalized from the boot rom environment.  The kernel console baud rate
will match the boot rom baud rate (it kind of needs to do this support
debugging modes).  If you want a different kernel baud rate, change the
boot rom baud rate.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
