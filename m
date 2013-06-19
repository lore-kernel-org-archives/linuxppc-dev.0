Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 868AE2C0299
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 16:18:40 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 02:18:37 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9A974C90026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 02:18:34 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J6IZhe282384
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 02:18:35 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J6IYRP008587
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 00:18:34 -0600
Date: Wed, 19 Jun 2013 14:18:32 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/31] powerpc/eeh: Move common part to kernel directory
Message-ID: <20130619061832.GA13311@shangw.(null)>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1371544435-4943-2-git-send-email-shangw@linux.vnet.ibm.com>
 <10320.1371614286@ale.ozlabs.ibm.com>
 <20130619061153.GA31968@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130619061153.GA31968@shangw.(null)>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 19, 2013 at 02:11:53PM +0800, Gavin Shan wrote:
>On Wed, Jun 19, 2013 at 01:58:06PM +1000, Michael Neuling wrote:
>>Bunch of whitespace issues here:
>>
>>% git am ~/Mail/linuxppc/31202
>>Applying: powerpc/eeh: Move common part to kernel directory
>>/home/mikey/src/powerpc-test/.git/rebase-apply/patch:437: trailing whitespace.
>>
>>/home/mikey/src/powerpc-test/.git/rebase-apply/patch:594: space before tab in indent.
>>  	 */
>>/home/mikey/src/powerpc-test/.git/rebase-apply/patch:607: trailing whitespace.
>>	
>>/home/mikey/src/powerpc-test/.git/rebase-apply/patch:608: trailing whitespace.
>>	/* We might get hit with another EEH freeze as soon as the 
>>/home/mikey/src/powerpc-test/.git/rebase-apply/patch:673: trailing whitespace.
>>	
>>error: patch failed: arch/powerpc/platforms/pseries/eeh_pe.c:1
>>error: arch/powerpc/platforms/pseries/eeh_pe.c: patch does not apply
>>Patch failed at 0001 powerpc/eeh: Move common part to kernel directory
>>When you have resolved this problem run "git am --resolved".
>>If you would prefer to skip this patch, instead run "git am --skip".
>>To restore the original branch and stop patching run "git am --abort".
>>
>
>Sorry for the inconvenience, Mikey. Please apply the updated [01/31] and [02/31] in
>the attachment. The left patches except [17/31] are not changed. The updated [17/31]
>will be contained in the attachment of the corresponding thread (original message
>about [17/31]). Something like:
>

Sorry, it's updated [14/31] instead of updated [17/31].

updated [01/31]
updated [02/31]
[03/31]
[04/31]
  :
  :
updated [14/31]		(not updated [14/31])
[18/31]
[19/31]
  :
  :
[31/31]

Thanks,
Gavin
