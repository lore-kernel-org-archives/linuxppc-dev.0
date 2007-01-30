Return-Path: <maynardj@us.ibm.com>
Message-ID: <45BFD016.5050302@us.ibm.com>
Date: Tue, 30 Jan 2007 17:09:10 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for	profiling
	Cell BE SPUs -- update
References: <45BE4ED0.5030808@us.ibm.com> <45BE4FA4.9020105@us.ibm.com>
	<200701300839.05144.arnd@arndb.de>
	<1170143630.26655.326.camel@localhost.localdomain>
	<20070130104120.GB14571@lst.de>
In-Reply-To: <20070130104120.GB14571@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:

> On Tue, Jan 30, 2007 at 06:53:50PM +1100, Benjamin Herrenschmidt wrote:
> 
>>>>+/* Defines used for sync_start */
>>>>+#define SKIP_GENERIC_SYNC 0
>>>>+#define SYNC_START_ERROR -1
>>>>+#define DO_GENERIC_SYNC 1
>>>>+
>>>>+typedef struct vma_map
>>>>+{
>>>>+       struct vma_map *next;
>>>>+       unsigned int vma;
>>>>+       unsigned int size;
>>>>+       unsigned int offset;
>>>>+       unsigned int guard_ptr;
>>>>+       unsigned int guard_val;
>>>>+} vma_map_t;
>>
>>I haven't had time to look in details yet but in that context, what does
>>"vma" stands for ? There's already an important vm data structure in
>>linux routinely called "vma" and thus I suspect this is a poor naming
>>choice as it will cause confusion.
> 
> 
> It looks like it actually is dealing with vma to me.  But then again:
> 
>  - please don't use typedefs for structures
>  - there might be a more descriptive name for this than just vma_map
Yes, I'll come up with some (hopefully) better name.
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> oprofile-list mailing list
> oprofile-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/oprofile-list
