Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18486.37948.843161.645634@cargo.ozlabs.ibm.com>
Date: Fri, 23 May 2008 19:54:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: New commits in powerpc.git powerpc-next branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have pushed the following commits to the powerpc-next and master
branches of the powerpc.git repository.  I have also pulled in Linus'
tree plus the 5 commits that I have put on the merge branch and asked
Linus to pull.

Paul.

Anton Vorontsov (1):
      [POWERPC] of/gpio: Use dynamic base allocation

Kumar Gala (1):
      [POWERPC] mpic: Deal with bogus NIRQ in Feature Reporting Register

Michael Ellerman (2):
      [POWERPC] Add debugging trigger to Axon MSI code
      [POWERPC] Remove unnecessary cast in arch_deref_entry_point()

Roland McGrath (1):
      [POWERPC] Tweak VDSO linker script to avoid upsetting old binutils
