Message-ID: <3B40713A.885F3C07@opensource.se>
Date: Mon, 02 Jul 2001 15:03:54 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: amyyah@china.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: *.ppc.rpm
References: <Vy989297798987.14472@mail2.china.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

This is not really a linuxppc-specific question...

How to unpack a rpm:

1. Make a new directory and enter it.
2. Try "rpm2cpio /path/to/the/rpm/rpm-file.foo.rpm | cpio -i " to unpack
the rpm.
3. If the rpm complains about missing directories, use "install -d" to
create the path.

Try "man rpm2cpio", "man rpm" and "man cpio" for more help!

And no, you do not need any complete cross environment to do that. =)

good luck /

Magnus

amyyah@china.com wrote:
>
> How can I  extract the *.ppc.rpm? such as rpm-4.0.2-6ax.ppc.rpm? Should I build the completed cross development environment?
> ************************************
> 留学移民,免费评估.
> http://www.mercan.com.cn/mercan2000/china.htm
>
> 定制中华网短信息（http://sms.china.com），天气、新闻、股市行情手触可得。
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
