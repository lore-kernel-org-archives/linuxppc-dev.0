Return-Path: <mlei30@yahoo.com>
Received: from web61008.mail.yahoo.com (web61008.mail.yahoo.com
	[216.155.196.97]) by ozlabs.org (Postfix) with SMTP id 2824367A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Apr 2005 12:11:27 +1000 (EST)
Message-ID: <20050429020445.24822.qmail@web61008.mail.yahoo.com>
Date: Thu, 28 Apr 2005 19:04:45 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
To: Glenn Burkhardt <glenn@aoi-industries.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel BUG at page_alloc.c:225 on PPC440GP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I cannot remember everything right now. There was a
problem with the init bootmem reservation that caused
this BUG. Two region of bootmem got overlapped
somehow.

--- Glenn Burkhardt <glenn@aoi-industries.com> wrote:
> I know it's been a year and a half since you
> submitted this report to the 
> mailing list, but was this problem ever resolved?  I
> think I'm seeing 
> something similar in the 2.4.23 kernel.
> 
> Thanks!
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
