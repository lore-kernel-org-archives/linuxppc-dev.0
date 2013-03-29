Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f54.google.com (mail-oa0-f54.google.com
 [209.85.219.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51C2F2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2013 15:50:56 +1100 (EST)
Received: by mail-oa0-f54.google.com with SMTP id n12so172593oag.41
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2013 21:50:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B0B119911@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1364464508-25393-1-git-send-email-Yuantian.Tang@freescale.com>
 <CAKohpomPubV=E_wCLyOR6X0PQNvrJpTc94950PEF+YUam9ituw@mail.gmail.com>
 <D07C73A334FF604B95B3CBD2A545D07B0B1178B6@039-SN2MPN1-013.039d.mgd.msft.net>
 <CAKohpom9=HmVDvSVvgPC1zdzHmd+YpMU85SW34b9jun1dp6+HA@mail.gmail.com>
 <D07C73A334FF604B95B3CBD2A545D07B0B119911@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Fri, 29 Mar 2013 10:20:53 +0530
Message-ID: <CAKohponzY8Lfx=PRnBdcC4UebeUJyQAwXMDJfHt-ANE+E6w-tA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] cpufreq: Add cpufreq driver for Freescale e500mc
 SoCs
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "rjw@sisk.pl" <rjw@sisk.pl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29 March 2013 10:17, Tang Yuantian-B29983 <B29983@freescale.com> wrote:
> I thought it was OK here. Apparently, sizeof(*table) is better.
> But kcalloc is OK.

Yes yes, Kcalloc is okay... I have misread that part earlier when i
suggested kzalloc.
In last mail i was referring to sizeof() only.
