Return-Path: <penberg@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by ozlabs.org (Postfix) with ESMTP id 2CCD2DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 19:19:35 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2312363rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 00:19:34 -0800 (PST)
Message-ID: <84144f020801230019i5ac6c8b1lfa5364672988b0c4@mail.gmail.com>
Date: Wed, 23 Jan 2008 10:19:33 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Sender: penberg@gmail.com
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: crash in kmem_cache_init
In-Reply-To: <Pine.LNX.4.64.0801221517260.2871@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0801171049190.21058@schroedinger.engr.sgi.com>
	<20080118225713.GA31128@aepfle.de> <20080122195448.GA15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221203340.27950@schroedinger.engr.sgi.com>
	<20080122212654.GB15567@csn.ul.ie>
	<Pine.LNX.4.64.0801221330390.1652@schroedinger.engr.sgi.com>
	<20080122225046.GA866@csn.ul.ie> <47967560.8080101@cs.helsinki.fi>
	<Pine.LNX.4.64.0801221501240.2565@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0801221517260.2871@schroedinger.engr.sgi.com>
Cc: lee.schermerhorn@hp.com, Olaf Hering <olaf@aepfle.de>,
	Linux MM <linux-mm@kvack.org>, Mel Gorman <mel@csn.ul.ie>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	hanth Aravamudan <nacc@us.ibm.com>, akpm@linux-foundation.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Christoph,

On Jan 23, 2008 1:18 AM, Christoph Lameter <clameter@sgi.com> wrote:
> My patch is useless (fascinating history of the changelog there through).
> fallback_alloc calls kmem_getpages without GFP_THISNODE. This means that
> alloc_pages_node() will try to allocate on the current node but fallback
> to neighboring node if nothing is there....

Sure, but I was referring to the scenario where current node _has_
pages available but no ->nodelists. Olaf, did you try it?

                        Pekka
