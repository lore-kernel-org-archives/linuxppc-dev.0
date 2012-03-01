Return-Path: <dsahern@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 011EA1007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2012 05:00:18 +1100 (EST)
Received: by dady9 with SMTP id y9so1149785dad.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Mar 2012 10:00:16 -0800 (PST)
Message-ID: <4F4FB92B.9080106@gmail.com>
Date: Thu, 01 Mar 2012 11:00:11 -0700
From: David Ahern <dsahern@gmail.com>
MIME-Version: 1.0
To: Victor Jimenez <victor.javier@bsc.es>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Sampling instruction pointer on PPC
References: <4F4FACFA.6080209@bsc.es>
In-Reply-To: <4F4FACFA.6080209@bsc.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-perf-users@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Added linuxppc-dev list.]

On 3/1/12 10:08 AM, Victor Jimenez wrote:
> I am trying to sample instruction pointer along time on a Power7 system.
> I know that there are accurate mechanisms to do so in Intel processors
> (e.g., PEBS and Branch Trace Store).
>
> Is it possible to do something similar in Power7? Will the samples be
> accurate? I am worried that significant delays (skids) may appear.
>
> Thank you,
> Victor
>
> WARNING / LEGAL TEXT: This message is intended only for the use of the
> individual or entity to which it is addressed and may contain
> information which is privileged, confidential, proprietary, or exempt
> from disclosure under applicable law. If you are not the intended
> recipient or the person responsible for delivering the message to the
> intended recipient, you are strictly prohibited from disclosing,
> distributing, copying, or in any way using this message. If you have
> received this communication in error, please notify the sender and
> destroy and delete any copies you may have received.
>
> http://www.bsc.es/disclaimer.htm
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
