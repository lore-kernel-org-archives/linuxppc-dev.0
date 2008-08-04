Return-Path: <paul@burly.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id 15A19DDF84
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 20:00:58 +1000 (EST)
From: Paul Collins <paul@burly.ondioline.org>
To: Neil Brown <neilb@suse.de>
Subject: Re: nfsd, v4: oops in find_acceptable_alias, ppc32 Linux,
	post-2.6.27-rc1
References: <87tze38vzt.fsf@burly.wgtn.ondioline.org>
	<20080802184554.GB715@fieldses.org>
	<87abfvm4cc.fsf@burly.wgtn.ondioline.org>
	<877iayy4qc.fsf@burly.wgtn.ondioline.org>
	<18581.40960.737792.454035@notabene.brown>
	<87r696l1yo.fsf@burly.wgtn.ondioline.org>
	<18582.32935.501672.689845@notabene.brown>
	<87fxpll5zq.fsf@burly.wgtn.ondioline.org>
Date: Mon, 04 Aug 2008 22:00:55 +1200
In-Reply-To: <87fxpll5zq.fsf@burly.wgtn.ondioline.org> (Paul Collins's message
	of "Mon, 04 Aug 2008 17:11:05 +1200")
Message-ID: <87y73dcd60.fsf@burly.wgtn.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, linuxppc-dev@ozlabs.org,
	nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Collins <paul@burly.ondioline.org> writes:

> Neil Brown <neilb@suse.de> writes:
>> Could you try removing the 'static' declaration for nfsd_acceptable
>> and recompile?
>> Or maybe try a different compiler?
>
> I will give these a try this evening.

I built myself a nice new cross compiler:

        powerpc-linux-gnu-gcc-4.1 (GCC) 4.1.3 20080623 (prerelease) (Debian 4.1.2-23)

and rebuilt 94ad374a0751f40d25e22e036c37f7263569d24c.  Running that on
the server and 2.6.26 on the client, I got yet another Oops.  This one
locked the machine up pretty good, so all I have is a picture:

http://ondioline.org/~paul/DSCN1608.JPG

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
