Message-ID: <3FD6369D.2090609@catapult.com>
Date: Tue, 09 Dec 2003 15:54:53 -0500
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: ATM Code
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to use some atm code for the 82xx.  The
driver is up and running, pace controller is moving,
the /proc is setup, there is not a /dev/atm but I
don't know if there should be one or not.

How do you create a simple AAL5 PVC with
CBR using this?  I have some example code,
but it appears to be out of date (or my code is)
and uses SO_BCTXOPT which is not supported.
Also when I open the socket with :
socket(PF_ATMPVC,  SOCK_DGRAM, ATM_AAL5)

returns Address family not supported by protocol?

Does anyone have some working example code on
how to do this or some pointers to up to date documentation?

Thank you
Kevin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
