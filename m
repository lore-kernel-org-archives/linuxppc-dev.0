Message-ID: <39CCD01E.CCEDB059@charter.net>
Date: Sat, 23 Sep 2000 10:45:34 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Manav Mediratta <manav@nimbus.tenet.res.in>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with ppcboot
References: <Pine.LNX.4.10.10009221804530.17865-100000@astra.tenet.res.in>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Manav Mediratta wrote:
> Hi folks
> Iam trying to boot my FADS with ppcboot and I have downloaded the files
> which support FADS ,from the CVS tree at Sourceforge but it seems fads.h
> isn't complete hence Iam not able to compile ppcboot for fads , although
> it compiles peacefully for TQM8xx .In case any of you folks have a work
> around for this then please let me know  .

Manav,
Interesting that... fads.h.  I didn't realize it was there I guess.
However, doing as the instruction say:
	$ make FADS850SAR_config
	$ make
works well here.  What sort of problems are you having?
If it is one of porting to new FADS hardware, then you will probably
want to work on one of the include/config_FADS* files, or create a
new one using the config_FADS850SAR.h as a model.  The 860T config
file has not been tested, and does not work.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
