Return-Path: <risto.suominen@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1234495590.26036.1.camel@pasglop>
References: <46e1c7760902120322r11cffbdcgff330a242ca586fb@mail.gmail.com>
	<1234495590.26036.1.camel@pasglop>
Date: Fri, 13 Feb 2009 17:58:27 +0200
Message-ID: <46e1c7760902130758g1bcc4c7j9607710bb6061af3@mail.gmail.com>
Subject: Re: [PATCH 002/002] de2104x: support for systems lacking cache
	coherence
From: Risto Suominen <risto.suominen@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=001636c5a3d45a2f9d0462cee801
Cc: LinuxPPC-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--001636c5a3d45a2f9d0462cee801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

2009/2/13, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>
> Can you tell me more about the mesh crash ? Do you have a log ?
>
Please find attached the device-tree and a log of loading the mesh
module after the boot. This way it didn't crash, but did odd things:
all it should find, on the bus, is a cd-rom drive at 3. Now it finds
two LUNs that it interprets as disks.

Risto

--001636c5a3d45a2f9d0462cee801
Content-Type: application/x-gzip; name="pmac5500-device-tree-2.6.24.tar.gz"
Content-Disposition: attachment;
	filename="pmac5500-device-tree-2.6.24.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr51dyam

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
aKiWeNwmAAAAYOD/AZpvFD0AAAUA
--001636c5a3d45a2f9d0462cee801
Content-Type: application/x-gzip; name="pmac5500-dmesg-mesh-2.6.24.gz"
Content-Disposition: attachment; filename="pmac5500-dmesg-mesh-2.6.24.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr51f7b7

H4sIALCVlUkAA61VbW/aMBD+zq+4b20lypwXXhopH9KCOjS1a4FuqqYpcuxLiAoxjR02/v1sQ4Fo
0HbqECg+8txzd0/uLnOU0wCYKNI8q0rkkIoS5Kpg01IUopLQhpvLT7Ixt7gFlvr+PC8yyItc5XQG
icaUKFG1Wq2GZDInEMDNYPx546JomaECr0ZKFbRbZM1sfEAyWgQwvL1/GI4eDV81U6CEADkVpYLT
9lkTKmniep21BwlI4Okf9PMSmTqPGEMp4R2fu/sACES346G+fiy88+HwRqSYJjrKKXN9nzFGzjbK
SUUVGqmYlySu2+41dWaZFY+1iYuEkCbwOd380e3pPxomAlMhgOuDxOfwogOJDH1CHEhZ6BDA3yzU
8bEszSWfh9DVz1IZQy7C1GtAmqcCOFU07Kb7Vo/sW8Q9bjk1P0KOW05v3/J5zXL2rbZfs2p5+nWW
i+N+dU6/zlJDurVc2rX6/PR41i45HqHOUo/g1Wrwaixezc/zj8dzX/Fz8XiETtt2jukm03Zhr4cE
2JwvVBl6qeN2ibPurcWUSgx9mMtsfSRmeRSxylToWa7Y+nRe+GKpQscedFsSKGLtKSp9tICX7RDo
1n4OXyYAMoEytiiQdInccm6GZSqkiu3G2Z9EV08iLnOGINJ0lhd6k51DIZTmpXwFNFVYmqbX203P
q1hiuWr0y1xf4UTyEygQuYRqoSswY34Oixnq8vTUo1lxsVotEOaopoLrlcV36+eH5PQnjAZRH66i
u+hqOHmElOYz5IdgdrMEYGpIVgrD/rAfX0b9eBKNrgcT4Daj9Z3R8NtgFH/90hw/XF8PxhN9PMA4
xkJnaAqlSx2VJjNsHYB9L3O9S+5KofSyglwalQ7AbgTHNaXeTWT7PYCM5JPRybwtGGVTtI/+eOGR
lJV9bdgK1y4B/LJZKf1WqLLpIS+lDJDD+Go8BJ7Lpx3IsaDkLel3sP8l/Zbxdem3sNel38LelH6L
fJ/0e/B/kH7n9bf0fwB+o2i7KwgAAA==
--001636c5a3d45a2f9d0462cee801--
