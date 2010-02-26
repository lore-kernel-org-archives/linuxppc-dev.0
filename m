Return-Path: <paulus@ozlabs.org>
Date: Fri, 26 Feb 2010 11:09:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] perf_event: Build callchain code regardless of
	hardware event support.
Message-ID: <20100226000948.GA7706@brick.ozlabs.ibm.com>
References: <20100226000433.GA17033@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100226000433.GA17033@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 25, 2010 at 06:04:33PM -0600, Scott Wood wrote:
> It's also useful for software events, as well as future support for
> other types of hardware counters.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Paul Mackerras <paulus@samba.org>
