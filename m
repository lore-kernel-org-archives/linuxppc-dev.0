Return-Path: <SRS0=3W5+=FD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2707C3E8C5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 18:46:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AA720825
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 18:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AA720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ckcl45551zDrTY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 05:46:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch
 (client-ip=185.16.172.187; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lunn.ch
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ckchx3mnXzDrQt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 05:44:17 +1100 (AEDT)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
 (envelope-from <andrew@lunn.ch>)
 id 1kjRfu-009NuK-W6; Sun, 29 Nov 2020 19:43:54 +0100
Date: Sun, 29 Nov 2020 19:43:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/8] net: ethernet: ibm: ibmvnic: Fix some kernel-doc
 misdemeanours
Message-ID: <20201129184354.GL2234159@lunn.ch>
References: <20201126133853.3213268-1-lee.jones@linaro.org>
 <20201126133853.3213268-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126133853.3213268-6-lee.jones@linaro.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Santiago Leon <santi_leon@yahoo.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Lijun Pan <ljp@linux.ibm.com>,
 Dany Madden <drt@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Lee

>  /**
>   * build_hdr_data - creates L2/L3/L4 header data buffer
> - * @hdr_field - bitfield determining needed headers
> - * @skb - socket buffer
> - * @hdr_len - array of header lengths
> - * @tot_len - total length of data
> + * @hdr_field: bitfield determining needed headers
> + * @skb: socket buffer
> + * @hdr_len: array of header lengths
> + * @tot_len: total length of data
>   *
>   * Reads hdr_field to determine which headers are needed by firmware.
>   * Builds a buffer containing these headers.  Saves individual header

The code is:

static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
                          int *hdr_len, u8 *hdr_data)
{

What about hdr_data? 

>  /**
>   * create_hdr_descs - create header and header extension descriptors
> - * @hdr_field - bitfield determining needed headers
> - * @data - buffer containing header data
> - * @len - length of data buffer
> - * @hdr_len - array of individual header lengths
> - * @scrq_arr - descriptor array
> + * @hdr_field: bitfield determining needed headers
> + * @data: buffer containing header data
> + * @len: length of data buffer
> + * @hdr_len: array of individual header lengths
> + * @scrq_arr: descriptor array

static int create_hdr_descs(u8 hdr_field, u8 *hdr_data, int len, int *hdr_len,
                            union sub_crq *scrq_arr)

There is no data parameter.

It looks like you just changes - to :, but did not validate the
parameters are actually correct.

	   Andrew
