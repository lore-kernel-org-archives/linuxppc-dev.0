Return-Path: <chris@2net.co.uk>
Received: from smtp808.mail.ukl.yahoo.com (smtp808.mail.ukl.yahoo.com
	[217.12.12.198]) by ozlabs.org (Postfix) with SMTP id D497368259
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 02:27:15 +1000 (EST)
Message-ID: <4326FDE1.3050300@2net.co.uk>
Date: Tue, 13 Sep 2005 17:27:13 +0100
From: Chris <chris@2net.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <4326968F.5030609@2net.co.uk>
	<20050913122541.GB9076@cathedrallabs.org>
	<20050913142513.GD10602@dmt.cnet>
In-Reply-To: <20050913142513.GD10602@dmt.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: gdb hangs on Linux 2.6.11 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Folks, 
> 
> Can you please upgrade to a recent kernel? 
> 
> A problem with ptrace has been fixed sometime ago, it might be what you're hitting.
> 
> The fix is part of v2.6.13:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bf85fa6c878aa3968df47d7f70a2b506c3e53b99
> 
> If that does not work, complain. 
> 

OK, that works. Gdb and gdbserver behave as they should.

Thanks,
Chris.
