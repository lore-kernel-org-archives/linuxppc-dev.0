Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: openssl
References: <75DF04AC5ED4D511A9810090273CB41661519B@ROKONET-E>
From: Roland Dreier <roland@topspin.com>
Date: 12 Mar 2003 08:55:40 -0800
In-Reply-To: <75DF04AC5ED4D511A9810090273CB41661519B@ROKONET-E>
Message-ID: <52r89cwmlv.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Eli> We don't have the /dev/random and /dev/urandom. How do we
    Eli> create them - mknod?

Yes,

  mknod /dev/random  c 1 8
  mknod /dev/urandom c 1 9

is all you need to do.

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
