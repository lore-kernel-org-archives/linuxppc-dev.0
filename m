Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CE28613.8090206@embeddededge.com>
Date: Wed, 15 May 2002 12:00:19 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: OTAVIO ISAMU SUGENO <otavio.sugeno@siemens.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to configure 2 ethernet devices
References: <B7AC573479F05C438F232539B961A168094FE9@CUR1006V.br002.siemens.net.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OTAVIO ISAMU SUGENO wrote:

> ......but when
> configuring the devices using bootp/rarpd in message IP-Config only
> appears:

The purpose of IP-Config is to provide a minimal network configuration
as to allow a network booting feature.  It will not completely initialize
a network environment suitable for little more than the NFS connection itself.

> IP-Config: Got RARP answer form 10.0.0.10, my address is 10.0.0.100
>
> I guess this is to the eth0 interface.

The IP-Config sends requests on all configured interfaces and accepts the
first one that replies.

> What do I need to configure in the HardHat Linux to receive a second ip
> address to the eth1?

You need to run the real user-land network configuration scripts and utilities
to properly configure a network on any system.  It should also be done even
when you are using IP-Config and network booting.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
