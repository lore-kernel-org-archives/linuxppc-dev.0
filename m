Message-ID: <394052F7.9DCCE9D7@centurysys.co.jp>
Date: Fri, 09 Jun 2000 11:14:15 +0900
From: Tania Boak <tania@centurysys.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: how to get called at shutdown
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all

I have a function I want to have called once at shutdown.  Can anyone
tell me a good way to do that?

I tried register_reboot_notifier() but for some reason I don't yet
understand my notification handler does not get called unless I use
shutdown with the -n (bypass init) option.  I would like something that
works regardless of the command used to reboot or shutdown.

Thanks,
Tania


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
