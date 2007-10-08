Return-Path: <ralferoo@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id 579D8DDF21
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 23:48:20 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1187940wxd
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 06:48:19 -0700 (PDT)
Message-ID: <18a15270710080648x3b5f1135meea3d7b048a1a543@mail.gmail.com>
Date: Mon, 8 Oct 2007 14:48:19 +0100
From: "Ranulf Doswell" <ralf@ranulf.net>
Sender: ralferoo@gmail.com
To: "geoffrey.levand@am.sony.com" <geoffrey.levand@am.sony.com>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
In-Reply-To: <20071006213542.954029915@am.sony.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1097_11495186.1191851299095"
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1097_11495186.1191851299095
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 06/10/2007, geoffrey.levand@am.sony.com <geoffrey.levand@am.sony.com>
wrote:
> enum os_area_db_owner {

> 	OS_AREA_DB_OWNER_ANY = -1,
> 	OS_AREA_DB_OWNER_NONE = 0,
>	OS_AREA_DB_OWNER_PROTOTYPE = 1,
>	OS_AREA_DB_OWNER_LINUX = 2,
>	OS_AREA_DB_OWNER_PETITBOOT = 3,
>	OS_AREA_DB_OWNER_MAX = 32,
>};
>
>enum os_area_db_key {
>	OS_AREA_DB_KEY_ANY = -1,
>	OS_AREA_DB_KEY_NONE = 0,
>	OS_AREA_DB_KEY_RTC_DIFF = 1,
>	OS_AREA_DB_KEY_VIDEO_MODE = 2,
>	OS_AREA_DB_KEY_MAX = 8,
>};

How do we go about claiming one of these OS_AREA_DB_OWNER_ keys? I'd very
much like to use this functionality in my python-ps3 games library.

My requirement is to be able to persist various options such as player names
and rankings. I had already been thinking about generating a unique token
and storing it somewhere at the end of the flash area so that when my game
connects to a game server, it can identify itself and be provided with all
the previous settings. Obviously, just claiming a random area of flash isn't
ideal, so your standardised solution would be perfect for this.

I would like, therefore, to reserve a single key to hold a 64-bit sized
token in order to identify the machine across reboots. I don't mind
particularly whether it's private to my application or a generally available
field, but certainly having an identifier I can rely on would be very
useful.

Cheers,
    Ralf.

------=_Part_1097_11495186.1191851299095
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><span class="gmail_quote">On 06/10/2007, <b class="gmail_sendername"><a href="mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com</a></b> &lt;<a href="mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com
</a>&gt; wrote:</span><div><br>&gt; enum os_area_db_owner {<br></div></div><pre>&gt; 	OS_AREA_DB_OWNER_ANY = -1,<br>&gt; 	OS_AREA_DB_OWNER_NONE = 0,<br>&gt;	OS_AREA_DB_OWNER_PROTOTYPE = 1,<br>&gt;	OS_AREA_DB_OWNER_LINUX = 2,
<br>&gt;	OS_AREA_DB_OWNER_PETITBOOT = 3,<br>&gt;	OS_AREA_DB_OWNER_MAX = 32,<br>&gt;};<br>&gt;<br>&gt;enum os_area_db_key {<br>&gt;	OS_AREA_DB_KEY_ANY = -1,<br>&gt;	OS_AREA_DB_KEY_NONE = 0,<br>&gt;	OS_AREA_DB_KEY_RTC_DIFF = 1,
<br>&gt;	OS_AREA_DB_KEY_VIDEO_MODE = 2,<br>&gt;	OS_AREA_DB_KEY_MAX = 8,<br>&gt;};</pre>How do we go about claiming one of these OS_AREA_DB_OWNER_ keys? I&#39;d very much like to use this functionality in my python-ps3 games library.
<br><br>My requirement is to be able to persist various options such as player names and rankings. I had already been thinking about generating a unique token and storing it somewhere at the end of the flash area so that when my game connects to a game server, it can identify itself and be provided with all the previous settings. Obviously, just claiming a random area of flash isn&#39;t ideal, so your standardised solution would be perfect for this.
<br><br>I would like, therefore, to reserve a single key to hold a 64-bit sized token in order to identify the machine across reboots. I don&#39;t mind particularly whether it&#39;s private to my application or a generally available field, but certainly having an identifier I can rely on would be very useful.
<br><br>Cheers,<br>&nbsp;&nbsp;&nbsp; Ralf.<br>

------=_Part_1097_11495186.1191851299095--
