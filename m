MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15047.12608.336940.84028@ipa.ne.mediaone.net>
Date: Sun, 1 Apr 2001 09:46:40 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: newer aic7xxx driver DOES WORK with cdrecord
In-Reply-To: <20010331171414.19066@smtp.wanadoo.fr>
References: <15045.61890.58237.453470@ipa.ne.mediaone.net>
	<20010331171414.19066@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:
 > The new driver is written & maintained by Justin T. Gibbs
 > <gibbs@scsiguy.com>, who is, I think, supported (or working for)
 > Adaptec. It's supposed to be _much_ better than the old one (and
 > actually gives better throughput on the 29160N in my G4).

As reported in my last message, the linuxcare sources are not using
Gibbs' latest patches, presumably because Linus hasn't approved them
yet.  The 6.1.5 driver included in that kernels doesn't work reliably
but the 6.1.8 driver does, at least for the one test that I just ran
(writing an iso image to a cd-r at 4x).  Can we get the 6.1.8 sources
into the linuxcare devel kernel?



--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
