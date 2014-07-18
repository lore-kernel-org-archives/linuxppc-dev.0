Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADED91A0334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 17:48:12 +1000 (EST)
Date: Fri, 18 Jul 2014 17:47:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/2] Split out struct kvmppc_vcore creation to
 separate function
Message-ID: <20140718074735.GA32094@iris.ozlabs.ibm.com>
References: <1405567197-23333-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1405657123-20087-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1405657123-20087-2-git-send-email-stewart@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405657123-20087-2-git-send-email-stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 18, 2014 at 02:18:42PM +1000, Stewart Smith wrote:
> No code changes, just split it out to a function so that with the addition
> of micro partition prefetch buffer allocation (in subsequent patch) looks
> neater and doesn't require excessive indentation.
> 
> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
