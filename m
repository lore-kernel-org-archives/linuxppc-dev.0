Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id E329CDDFD7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 May 2008 20:16:07 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K0ZkK-0005IG-PQ
	for linuxppc-embedded@ozlabs.org; Mon, 26 May 2008 03:16:04 -0700
Message-ID: <17469227.post@talk.nabble.com>
Date: Mon, 26 May 2008 03:16:04 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Building Cross Compiler for MPC8260ADS
In-Reply-To: <4836BE5D.3010209@aimvalley.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <17421912.post@talk.nabble.com> <4836BE5D.3010209@aimvalley.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Mr Bolhuis 

Thanks for your reply. i did the same what you suggested,but while running
the script its asking to set the enviourmnental variable like
TARGET,PREFIX,GCC,GCC_FLAG etc which unknowlingly how can we set. Is there a
config file that should tell us what are the enviourmnental variable to be
set.

regards 
Misbah <><




Norbert van Bolhuis-2 wrote:
> 
> 
> you can build cross gcc compilers with crosstool.
> this is a tool (script) that does everything for you,
> see http://kegel.com/crosstool
> 
> -- 
> This message has been scanned for viruses and is believed to be clean
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Building-Cross-Compiler-for-MPC8260ADS-tp17421912p17469227.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
