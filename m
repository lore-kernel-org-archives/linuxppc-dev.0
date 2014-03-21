Return-Path: <ego@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34F322C00B0
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 19:20:05 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 02:20:03 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4E7ADC9003E
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 04:19:55 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2L8JwMp8716692
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 08:19:58 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2L8JwNA008579
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 04:19:58 -0400
Date: Fri, 21 Mar 2014 13:49:42 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/5] powernv: Enable Dynamic Frequency
Message-ID: <20140321081942.GE27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=mYnRWEqs=qBi4C4OWog+ds85=e+uDTJGpojozEr-XKhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOh2x=mYnRWEqs=qBi4C4OWog+ds85=e+uDTJGpojozEr-XKhQ@mail.gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Viresh,

On Fri, Mar 21, 2014 at 01:16:03PM +0530, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > This is the v3 of the consolidated patchset consisting
> > patches for enabling cpufreq on IBM POWERNV platforms
> > along with some enhancements.
> 
> This is the first time I saw them. Looks like you never Cc'd linux-pm list.
> Also, would be better to keep Maintainers in --to field so that they can
> review them as soon as possible. Otherwise they might stay on lists for
> a long time..

Yes, I hadn't Cc'ed linux-pm list last time around. Sorry about
that. Will keep this in mind the next time around. Also, your
suggestion regarding keeping the Maintainers in --to field is well
taken.

--
Thanks and Regards
gautham.
> 
