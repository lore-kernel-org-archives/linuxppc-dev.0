Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115854.GA12006@kryten>
Message-Id: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:49:57 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 00/10] PowerPC address space randomisation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following set of patches adds randomisation of mmaps, heap and
position independent executables, and increases the randomisation applied to
the stack on 64bit binaries.

-- 
