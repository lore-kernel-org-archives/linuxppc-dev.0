Date: Wed, 10 Jan 2001 21:04:29 +0100
Subject: Re: /proc/sys/net/ipv4/ip_always_defrag
From: Chris Boot <bootc@worldnet.fr>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B6827EDD.82D0%bootc@worldnet.fr>
In-Reply-To: <20010110114626.I27006@sophix.uklinux.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Chris Boot [bootc@worldnet.fr] wrote:
>
>> One minor problem though, is that when I boot up (from a LinuxPPC 2000
>> installation), after the "Entering non-interactive startup" message, I
>> get a message stating that it could not find the file
>> "/proc/sys/net/ipv4/ip_always_defrag", which it tries to set to "1" by
>> echoing to it.  Can this be ignored?  Is there a way of either getting
>> this proc entry back or removing the script code that echoes to it?  I
>> must admit that I haven't looked at any of the files in /etc/rc.d with
>> great detail...
>
> this is controlled by /etc/sysctl.conf

I _have_ no /etc/sysctl.conf file...  I never have had...  I'll just have to
hunt through all my rc scripts to find it.

--
    .-.        Chris Boot
    /v\     bootc@worldnet.fr
   // \\
  /(   )\   L   I   N   U   X
   ^^-^^   >Phear the Penguin<


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
