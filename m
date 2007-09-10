Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id F1F4BDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 04:20:13 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so538721nzh
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 11:20:11 -0700 (PDT)
Message-ID: <fa686aa40709101120u1310845et866b8fa6df7c5154@mail.gmail.com>
Date: Mon, 10 Sep 2007 12:20:10 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Babarovic Ivica" <ivica.babarovic@asist.si>
Subject: Re: Which 2.6 kernel for MPC5200
In-Reply-To: <46E57A9D.2020506@asist.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46E57A9D.2020506@asist.si>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/10/07, Babarovic Ivica <ivica.babarovic@asist.si> wrote:
> Hi!
>
> What kernel should I get/pull for MPC5200 clone board.
> I've been away from coding on mpc5200 for quite some time now.
> I've read some archives from ML.
> Git repo on Sylvain Munauts url:
> http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx.gitpage
> isn't working. Nothing on http://*git*.secretlab.ca/cgi-bin/*gitweb*.cgi
> <http://git.secretlab.ca/cgi-bin/gitweb.cgi> to.
>
> I've pulled the sources from kernel.org git server.
> git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> linux-2.6-mpc52xx

My 52xx git tree became way out of date, so I dropped it from the
server.  Best bet is to use mainline which gives your everything
except the drivers that use the bestcomm DMA engine (like Ethernet).

Then you need to apply the bestcomm patches.  You can get them here:

http://www.246tnt.com/mpc52xx/dev_full/

Have fun,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
