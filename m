From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] Retrace
Date: Wed, 9 Feb 2000 13:45:15 +1100
Content-Type: text/plain
References: <Pine.LNX.4.05.10002081101510.27293-100000@callisto.of.borg>
MIME-Version: 1.0
Message-Id: <00020913455600.26444@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 08 Feb 2000, Geert Uytterhoeven wrote:

> Nope. But perhaps we should remove the #if !defined(CONFIG_PPC) around the
> port operations in drivers/char/mem.c?

Sounds like a good way to get machine checks to me.  But then only root can
do it so maybe it doesn't matter.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
