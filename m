Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E4F22C007D
 for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2012 04:06:56 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 19 Oct 2012 11:06:53 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7EF1D19D8043
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 11:06:49 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9JH6Ce4176964
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 11:06:12 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9JH4bvI002073
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 11:04:38 -0600
Date: Fri, 19 Oct 2012 10:05:39 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Stephane Eranian <eranian@google.com>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
Message-ID: <20121019170538.GB28183@us.ibm.com>
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com>
 <20121016100809.GS8285@erda.amd.com>
 <CABPqkBRd2wfjd1ObCkM+TSSwt7C9WP65dEE9POSyDK1ccvNL8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABPqkBRd2wfjd1ObCkM+TSSwt7C9WP65dEE9POSyDK1ccvNL8A@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Robert Richter <robert.richter@amd.com>,
 Anton Blanchard <anton@au1.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Paul Mackerras <paulus@samba.org>,
 mpjohn@us.ibm.com, Ingo Molnar <mingo@kernel.org>,
 Arun Sharma <asharma@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephane Eranian [eranian@google.com] wrote:
| So all in all, I think this is not a very good idea. You have to put
| this into the tool or a library that auto-detects the
| host CPU and programs the right set of events.
| 
| We've had that discussion many times. Just reiterating my personal
| opinion on this.

Yes that would work too. One drawback is that the hardware events
will be in the tool, while the software/tracepoint events in the
kernel sysfs representation.

Or is that the reason we want all events in one place (sysfs) ?

Sukadev
