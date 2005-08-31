Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF916681EB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 19:03:16 +1000 (EST)
Date: Wed, 31 Aug 2005 10:03:12 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "lily" <lichanjuan04@st.lzu.edu.cn>
Message-Id: <20050831100312.64a2354f.ajz@cambridgebroadband.com>
In-Reply-To: <325470355.17275@st.lzu.edu.cn>
References: <325470355.17275@st.lzu.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux kernel does not bring up!!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 31 Aug 2005 15:05:24 +0800
"lily" <lichanjuan04@st.lzu.edu.cn> wrote:

> ET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 1691k freed
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 76k init
> init started:  BusyBox v0.60.5 (2005.06.06-14:19+0000) multi-call binary
> rm: cannot remove `/www/log/seriald_started.log': No such file or directory
> 
> but this message just print once ,what's the problem with the board ,does it destroy
> there is somebody give me some suggestion what i do next.Thanks !!

This question is off topic here.

You need to read "man init" and "man inittab" and your /etc/inittab to find out which startup
scripts are being called.  You can then find the script which is attempting to remove the
nonexistent file, and fix it (e.g. by using rm -f instead).

This list cannot help any further as this is not related to the PPC port of linux.

Alex
