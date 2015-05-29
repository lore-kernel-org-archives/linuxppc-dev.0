Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77CBF1A3844
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 19:20:42 +1000 (AEST)
Date: Fri, 29 May 2015 11:13:15 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] perf, tools: Handle header line in mapfile
Message-ID: <20150529091140.GA20512@krava.redhat.com>
References: <1432761809-4344-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432761809-4344-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150528124221.GK12392@krava.redhat.com>
 <20150529054506.GA3088@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150529054506.GA3088@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 28, 2015 at 10:45:06PM -0700, Sukadev Bhattiprolu wrote:
> Jiri Olsa [jolsa@redhat.com] wrote:
> | >  		if (line[0] == '#' || line[0] == '\n')
> | >  			continue;
> | > +		if (!strncmp(line, "Family", 6))
> | > +			continue;
> | 
> | I think we should fix mapfiles to put the 'Family' starting
> | line as a comment.. the way powerpc mapfile is done
> 
> You mean add something like this to the Intel mapfile:
> 
> 	# Power8 entries
> 	004d0100,1,power8.json,core
> 
> and drop this patch?

right

jirka
