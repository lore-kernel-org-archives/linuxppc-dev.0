Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rh6lJ3HpWzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 06:02:35 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61JxwRV097575
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 16:02:31 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23w76q51kf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 16:02:31 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 17:02:29 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 862001DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 16:02:18 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u61K2Q8A4808890
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 17:02:26 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u61K2PLV026912
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 17:02:26 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Date: Fri, 01 Jul 2016 17:02:23 -0300
In-Reply-To: <20160701183602.GA4553@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <3713936.n8FBhAAd79@hactar>
 <20160701183602.GA4553@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <3789971.1TYeJNg8TK@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 01 Juli 2016, 14:36:02 schrieb Dave Young:
> On 07/01/16 at 02:51pm, Thiago Jung Bauermann wrote:
> > Am Donnerstag, 30 Juni 2016, 17:43:57 schrieb Dave Young:
> > > On 06/30/16 at 01:42pm, Thiago Jung Bauermann wrote:
> > > > Am Donnerstag, 30 Juni 2016, 12:49:44 schrieb Thiago Jung Bauermann:
> > I understand that this is all somewhat subjective, so if you still
> > disagree with my points I can provide a patch set implementing the
> > change above.
> I still feel it should be changed if more callbacks being introduced,
> though you can regard it is internal api, like above comment we do not
> need to assign them seperately, the member values can be assigned
> from the beginning.

Ok, I'll implement the changes and submit a v4. Thanks for your review.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
