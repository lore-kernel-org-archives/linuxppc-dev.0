Return-Path: <dale@farnsworth.org>
To: Linuxppc-embedded@ozlabs.org
In-Reply-To: <E1KghMP-00065i-BC@xyzzy.farnsworth.org>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56DCA7@insardxms01.ap.sony.com>
Message-Id: <E1KgjEf-0007MQ-Fq@xyzzy.farnsworth.org>
From: Dale Farnsworth <dale@farnsworth.org>
Date: Fri, 19 Sep 2008 09:53:37 -0700
Subject: Re: Regarding select() on PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I wrote:
> Interesting.  The man page for select says that select should return
> EINVAL when the first argument is negative.  By that, only ppc32 is
> correct.  :)

Sorry.  I should read before posting.  Please ignore my extraneous
comment above.

-Dale
