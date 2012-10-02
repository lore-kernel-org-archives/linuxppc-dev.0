Return-Path: <kosaki.motohiro@gmail.com>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D7C8E2C0133
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 03:29:41 +1000 (EST)
Received: by oagn12 with SMTP id n12so6730668oag.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2012 10:29:39 -0700 (PDT)
MIME-Version: 1.0
Sender: kosaki.motohiro@gmail.com
In-Reply-To: <506A4100.7070305@jp.fujitsu.com>
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <1346837155-534-2-git-send-email-wency@cn.fujitsu.com>
 <506509E4.1090000@gmail.com> <50651E68.3040208@jp.fujitsu.com>
 <CAHGf_=oJ_Jmjqcdr4cPJghf7PX+vfmZe=CV2sdQQhS5agzG15w@mail.gmail.com>
 <506A4100.7070305@jp.fujitsu.com>
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Tue, 2 Oct 2012 13:29:19 -0400
Message-ID: <CAHGf_=rNSmtxw2JL2g+b-yq9KTFZPWBp90KtERJouDS-vv3zWw@mail.gmail.com>
Subject: Re: [RFC v9 PATCH 01/21] memory-hotplug: rename remove_memory() to
 offline_memory()/offline_pages()
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 wency@cn.fujitsu.com, linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org,
 len.brown@intel.com, x86@kernel.org, Ni zhan Chen <nizhan.chen@gmail.com>,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 paulus@samba.org, minchan.kim@gmail.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Then, you introduced bisect breakage. It is definitely unacceptable.
>
> What is "bisect breakage" meaning?

Think what's happen when only applying path [1/21].
