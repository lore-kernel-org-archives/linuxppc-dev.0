Date: Tue, 16 Sep 2003 11:03:04 -0500
Subject: Re: combine PPC "general setup" and "platform setup"?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Tom Rini <trini@kernel.crashing.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <620524B0-E7F4-11D7-B6C9-000A95A0560C@penguinppc.org>
Message-Id: <41275CE1-E85F-11D7-A8BC-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday, Sep 15, 2003, at 22:18 US/Central, Hollis Blanchard wrote:
>
> I noticed some obsolete config options (e.g. CONFIG_SERIAL_CONSOLE,
> CONFIG_PC_KEYBOARD). Also, it's possible to create incorrect
> configurations such as CONFIG_POWER3 and CONFIG_SPRUCE. Also, APUS
> really deserves its own config file, and the "IBM 4xx options" menu
> should be hidden if !CONFIG_4xx. A lot of configure help is also
> missing, especially on embedded options. I figure these can be later
> patches.

I forgot to mention that the patch was relative to linuxppc-2.5.

Here's another: briefly tested, seems to work.

===== arch/ppc/platforms/4xx/Kconfig 1.11 vs edited =====
--- 1.11/arch/ppc/platforms/4xx/Kconfig Wed Sep  3 08:02:12 2003
+++ edited/arch/ppc/platforms/4xx/Kconfig       Tue Sep 16 10:58:26 2003
@@ -4,6 +4,7 @@
         default y

  menu "IBM 4xx options"
+       depends 4xx

  choice
         prompt "Machine Type"

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
