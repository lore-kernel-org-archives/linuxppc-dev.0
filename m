Subject: 8xx block address mapping...
To: Dan Malek <dan@embeddededge.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFFCEBF3AF.F02EB770-ON85256EDF.005C805F-85256EDF.005D5409@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Wed, 28 Jul 2004 12:59:22 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

I am just curious about how the 8xx does a block mapping (e.g. mapping a
video frame buffer) without BATs.

Here are the 2 possilbilities I can think of for a 2 megabyte block.

- it allocates the smallest possible page size for the block requested.
i.e. it will have to allocate an 8-Myte page for the 2-Mbyte block, very
wasteful it seems.

- pages can be allocated such that a contiguous region of physical memory
can be mapped to the 2-Mbyte block, I can't imagine how this can take place
in the 8xx MMU.

Could you shed some light on how this works.  It will help me assess how
efficient block mapping is on the 8xx.

Thanks a lot,

David Ho


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
