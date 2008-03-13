Return-Path: <SRS0=Oat7=T7=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 58E3DDE09D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 03:21:34 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: slow Kilauea TCP throughput?
Date: Thu, 13 Mar 2008 17:21:24 +0100
References: <9E33F44949583B4597BDA2D06042567003734A0F@FLS-EXCHANGE.corp.sds.l-3com.com>
In-Reply-To: <9E33F44949583B4597BDA2D06042567003734A0F@FLS-EXCHANGE.corp.sds.l-3com.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803131721.24371.sr@denx.de>
Cc: "Donasch, Ingo @ SDS" <Ingo.Donasch@l-3com.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 March 2008, Donasch, Ingo @ SDS wrote:
> I have a project where I would like to use the AMC405EX under Linux for
> high speed data acquisition. I have the Kilauea board in the lab but
> measured only 150Mbit/s TCP throughput (outbound) with iperf. I need
> twice of that and actually expecting 3x higher bandwidth from that
> architecture.

I'm not sure if 3 times the performace will be possible. Why did you expect 
such a performance btw?

> what is it that I'm missing?
> can anybody confirm my results or tell me what am I doing wrong?

I just ran some iperf tests and they show similar results. I'll currently 
comparing them to other 4xx platforms. Perhaps this gives some infos on what 
is happening here and where the bottleneck lies.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
