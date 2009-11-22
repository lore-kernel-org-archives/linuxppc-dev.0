Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 03FD0100820
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 10:39:11 +1100 (EST)
Received: by yxe9 with SMTP id 9so4926913yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 Nov 2009 15:39:10 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 22 Nov 2009 16:38:50 -0700
Message-ID: <fa686aa40911221538s46a81acal9b451bf48873b6be@mail.gmail.com>
Subject: Re: [RFC PATCH 15/19] powerpc: broadway processor support
To: Albert Herranz <albert_herranz@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
> This patch extends the cputable entry of the 750CL to also match
> the 750CL-based "Broadway" cpu found on the Nintendo Wii.
>
> As of this patch, the following "Broadway" design revision levels have
> been seen in the wild:
> - DD1.2 (87102)
> - DD2.0 (87200)

Please respin without the reordering of CPU table entries.  If you
want to reorder, then do it in a separate patch.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
