Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 737B1679E2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Mar 2006 01:01:12 +1100 (EST)
In-Reply-To: <200603140850.47014.david.jander@protonic.nl>
References: <20060310153341.080163525CB@atlas.denx.de>
	<200603140850.47014.david.jander@protonic.nl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <409257f58f9dab82d72ccd997516f772@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Stable Linux kernel 2.6 for MPC8XX
Date: Tue, 14 Mar 2006 09:01:37 -0500
To: David Jander <david.jander@protonic.nl>
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


On Mar 14, 2006, at 2:50 AM, David Jander wrote:

> I don't know why, but while everyone still says 2.6 is slower, I am
> consistently getting results that seem to prove the opposite. Why?

Because this is a compiler test and not an OS test.  The
newer ELDK with 2.6 has better compilers.


	-- Dan
