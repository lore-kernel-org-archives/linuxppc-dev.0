From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Masik <masik@pc203b.fzu.cz>,
	<linuxppc-dev@lists.linuxppc.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Occasional crash reports
Date: Tue, 14 Aug 2001 18:45:14 +0200
Message-Id: <20010814164514.17955@smtp.adsl.oleane.com>
In-Reply-To: <20010814162827.16595@smtp.adsl.oleane.com>
References: <20010814162827.16595@smtp.adsl.oleane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Make sure you have the latest yaboot (1.2.3), and add an initrd=<path>
>line to your yaboot.conf in order to load the kernel's System.map along
>with the kernel image. Also, enable xmon in your kernel. This will give
>you some symbols lookup in xmon backtrace which is cool :)

Hrm... I should sleep sometimes... read "sysmap=" and not "initrd=" !

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
