Return-Path: <asharma@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACC142C00A3
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 04:42:01 +1100 (EST)
Message-ID: <507C467E.8010205@fb.com>
Date: Mon, 15 Oct 2012 10:23:10 -0700
From: Arun Sharma <asharma@fb.com>
MIME-Version: 1.0
To: Robert Richter <robert.richter@amd.com>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com>
In-Reply-To: <20121015155534.GR8285@erda.amd.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: peterz@infradead.org, Anton
 Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org, eranian@google.com,
 acme@redhat.com, linuxppc-dev@ozlabs.org, paulus@samba.org, mpjohn@us.ibm.com,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/15/12 8:55 AM, Robert Richter wrote:

[..]
> Perf tool works then out-of-the-box with:
>
>   $ perf record -e cpu/stalled-cycles-fixed-point/ ...
>
> The event string can easily be reused by other architectures as a
> quasi standard.

I like Robert's proposal better. It's hard to model all the stall events 
(eg: instruction decoder related stalls on x86) in a hardware 
independent way.

Another area to think about: software engineers are generally busy and 
have a limited amount of time to devote to hardware event based 
optimizations. The most common question I hear is: what is the expected 
perf gain if I fix this? It's hard to answer that with just the stall 
events.

  -Arun
