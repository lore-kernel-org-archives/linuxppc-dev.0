Message-ID: <391AE635.EE6D623C@netx4.com>
Date: Thu, 11 May 2000 12:56:21 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
CC: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
        cort@fsmlabs.com
Subject: Re: NO_RELOAD_HTAB
References: <391A15CE.41488C9D@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan A. Dickey wrote:

> So, I was wondering what NO_RELOAD_HTAB is for before I go
> delving into 860 & 850 mmu differences and the linux code
> for them.

That #define has no effect on the 8xx MMU functions.  The
8xx MMU is significantly different from the other "bigger"
processor cores.

> If anyone else is reading this, can you verify that your
> linux code runs on both an 860 and 850 with no changes?

Yes, it does.  Every day, for years......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
