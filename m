Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: "Noguchi, Masato" <Masato.Noguchi@jp.sony.com>
Subject: Re: [Cbe-oss-dev] [PATCH 09/14] spufs: add support for read/write
	oncntl
Date: Tue, 10 Oct 2006 10:11:25 +0200
References: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3D7@jptkyxms38.jp.sony.com>
In-Reply-To: <C3DCD550FB9ACD4D911D1271DD8CFDD20113D3D7@jptkyxms38.jp.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610101011.27949.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 10 October 2006 08:00, Noguchi, Masato wrote:
> After applying these patches, it seems the kernel leaks memory.
> No doubt you forget to call simple_attr_close on "[PATCH 09/14]
> spufs: add support for read/write oncntl".

Ok, thanks for pointing this out.
 
> Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Paul, please apply.

	Arnd <><
