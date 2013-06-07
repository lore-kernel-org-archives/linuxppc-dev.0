Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A46952C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 10:25:15 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 6 Jun 2013 20:25:11 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1B015C90042
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 20:25:07 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r570P7bL288352
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 20:25:07 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r570P5Hl022947
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 20:25:07 -0400
Date: Fri, 7 Jun 2013 08:24:59 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Robert Knight <knight@princeton.edu>
Subject: Re: IBM OpenPower 720 ipr driver woes
Message-ID: <20130607002459.GA5512@shangw.(null)>
References: <51A61B82.5050508@princeton.edu>
 <51A644C2.5090300@linux.vnet.ibm.com>
 <51AD088C.8040803@princeton.edu>
 <20130604000130.GA25055@thor.bakeyournoodle.com>
 <51AD45A4.9080702@princeton.edu>
 <20130604031651.GA3373@thor.bakeyournoodle.com>
 <20130604035223.GA27964@shangw.(null)>
 <51AFAA2C.5060304@princeton.edu>
 <51B07336.7040609@linux.vnet.ibm.com>
 <51B08311.3080406@princeton.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51B08311.3080406@princeton.edu>
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Wendy Xiong <wenxiong@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 06, 2013 at 08:39:45AM -0400, Robert Knight wrote:
>On 06/06/2013 07:32 AM, Brian King wrote:
>>On 06/05/2013 04:14 PM, Robert Knight wrote:
>>>On 6/3/2013 11:52 PM, Gavin Shan wrote:
>>>>On Tue, Jun 04, 2013 at 01:16:52PM +1000, Tony Breeds wrote:
>>>>>On Mon, Jun 03, 2013 at 09:40:52PM -0400, Robert Knight wrote:
>>>>>>On 6/3/2013 8:01 PM, Tony Breeds wrote:
>>>>>>>On Mon, Jun 03, 2013 at 05:20:12PM -0400, Robert Knight wrote:

.../...

>Yes.  I've started rebuilding the kernel and I'm up to the module
>building part, so I'd say it is solid.  Will this patch make it into
>some version of the kernel?
>

The patch is being pushed to mainline or linux-next, and backported
to stable-kernel (v3.4+)


>What was killing me was that it would not complete boot.  It now
>does.  I see:
>
>[   11.934481] scsi 0:0:15:0: Resetting device
>[   11.934813] ipr 0001:d0:01.0: Adapter being reset as a result of
>error recovery.
>
>on each boot.  It does not appear to affect operation.
>
>Thank you and the rest of the team for your rapid and helpful responses.
>

Thanks,
Gavin
