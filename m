Return-Path: <albert_herranz@yahoo.es>
Received: from smtp149.mail.ukl.yahoo.com (smtp149.mail.ukl.yahoo.com
	[77.238.184.80]) by ozlabs.org (Postfix) with SMTP id A62FEB7DAB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Mar 2010 06:13:48 +1100 (EST)
Message-ID: <4BA3CCE3.1010907@yahoo.es>
Date: Fri, 19 Mar 2010 20:13:39 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v5 00/10] wii: add usb 2.0 support
References: <Pine.LNX.4.44L0.1003191452310.18602-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1003191452310.18602-100000@netrider.rowland.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, konrad.wilk@oracle.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Stern wrote:
>> Alan: I think you are also working in a patchset to make {un}map_urb_for_dma
>> remember how the urb was mapped, right?
> 
> Yes; you can see an initial version here:
> 
> 	http://marc.info/?l=linux-usb&m=126901183419219&w=2
> 
> This is a bug fix, so it's likely to be merged before your work.
> 
> It's a messy situation, with two people changing the same code at the
> same time.  I think the best approach will be to wait until the bug-fix
> patch is tested and accepted; then I can create a version of your 5/10
> and 6/10 patches adding HCD_NO_COHERENT_MEM and the corresponding
> behavior.  That can stand by itself, and once it is accepted the rest
> of your series should go through with no difficulty (at least, no
> difficulties involving the USB core!).

Agreed. I'll keep an eye on these developments.

> 
> Alan Stern
> 

Thanks a lot,
Albert
