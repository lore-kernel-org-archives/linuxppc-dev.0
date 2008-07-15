Return-Path: <arnd@arndb.de>
Message-Id: <20080715195139.316677337@arndb.de>
Date: Tue, 15 Jul 2008 21:51:39 +0200
From: arnd@arndb.de
To: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [patch 0/9] Cell patches for 2.6.27, version 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

These are the remaining patches I have lined up for 2.6.27.
Thanks for including the others already. There were a few
comments in the last round that I hope all got addressed now.

I'm not sure about the final two patches for the IOMMU, I think
you wanted to investigate the situation more, but I haven't
seen an update from you any more. I'm convinced going to weak
ordering is the right move for the cell IOMMU, and even if it
is not, it will not break anything on current machines because
the firmware already overrides this setting.

I have left the copy_to_user in AZFS in place, I think we
need to follow up on this again, to either document that
copy_fromto_user needs to be able to work on uncached memory,
or to do an extra copy, but I think this should not hold up
the AZFS merge. All other comments for it have been addressed.

You can pull from the usual location at

master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git cell-next

	Arnd <><

--
