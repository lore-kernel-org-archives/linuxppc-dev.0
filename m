Return-Path: <zejdlp1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
	by ozlabs.org (Postfix) with ESMTP id ABE3EDDE26
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 23:53:45 +1100 (EST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 3A79F390EC171
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 13:47:51 +0100 (CET)
Received: from [192.168.1.100] (pha-1-13.adsl.sky.cz [193.165.1.13])
	by imap.feld.cvut.cz (Postfix) with ESMTP id 2035C3FF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Mar 2008 13:47:50 +0100 (CET)
Message-ID: <47D7D0F2.9080803@fel.cvut.cz>
Date: Wed, 12 Mar 2008 13:47:46 +0100
From: =?UTF-8?B?UGV0ciDFvWVqZGw=?= <zejdlp1@fel.cvut.cz>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 2.6.23.1 and more than 32MB, segfault
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm using MEMEC board ML300 compatible with 64MB SDRAM available and 
vanilla kernel 2.6.23.1. The problem are random segfaults from init, 
sometimes before init when using more than 32MB ram. Everything is OK 
only when memory is limited to 32MB (mem=32M).

Thank You for any advice.
Petr
