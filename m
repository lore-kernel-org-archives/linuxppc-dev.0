Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id E0DDEB7C11
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 03:41:20 +1100 (EST)
Received: by yxe8 with SMTP id 8so5329819yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 08:41:19 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AEF086D.9010600@austin.ibm.com>
References: <4AE8ADCF.6090104@austin.ibm.com>
	<4AE8AF4D.4030403@austin.ibm.com>
	<1256785731.26770.38.camel@pasglop> <4AEF086D.9010600@austin.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 2 Nov 2009 09:40:59 -0700
Message-ID: <fa686aa40911020840s3a6a4819g85f3be3a305820bf@mail.gmail.com>
Subject: Re: [PATCH 1/6 v5] Kernel DLPAR Infrastructure
To: Nathan Fontenot <nfont@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 2, 2009 at 9:27 AM, Nathan Fontenot <nfont@austin.ibm.com> wrote:
> I saw that Grant Likely is doing updates to all of the of_* stuff right now,
> would it be ok to have these routines here, renamed as dlpar_*, and look
> to merge them in with Grant's updates when he finishes?

No because then we're stuck with renaming the API at a later date.
Name it what it is, and put it where it belongs.  I'll deal with any
merge breakage as it occurs.

g.
