Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Date: Mon, 10 May 2004 15:46:38 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] u-boot 1.1.1
Message-ID: <20040510134638.GW14935@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040510121358.GV14935@smtp.barco.com>
Mime-Version: 1.0
In-Reply-To: <20040510121358.GV14935@smtp.barco.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


oops:

 -    CONFIG_READ_BYTE(PCMBRCR,val);
 +    CONFIG_READ_BYTE(PCMBCR,val);

 or :%s/PCMBRCR/PCMBCR/g

This is what happens when "typing over" from !@#$%!@#$! MKS

	marc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
