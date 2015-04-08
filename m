Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59C301A0515
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 20:12:32 +1000 (AEST)
Date: Wed, 8 Apr 2015 06:12:21 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv9 RFC 1/3] Break up monolithic iommu table/lock into
 finer graularity pools and lock
Message-ID: <20150408101221.GS29504@oracle.com>
References: <cover.1428181553.git.sowmini.varadhan@oracle.com>
 <a259c5bbc3d98dbaedc73a88250a5e7c937ec5f9.1428181553.git.sowmini.varadhan@oracle.com>
 <1428481825.18187.10.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428481825.18187.10.camel@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (04/08/15 18:30), Benjamin Herrenschmidt wrote:
> 
> I'm happy with your last version, feel free to add my
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

sounds good, I'll do this and rese a non-RFC version today.

Thanks for all the feedback - it was very useful to me, and
I'm much happier with the end-result.

--Sowmini
